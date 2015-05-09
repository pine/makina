#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require 'logger'
require_relative './uri'


module Makina
  module Skype
    class Chat
      def initialize(skype, users, log = nil)
        @skype = skype
        @users = users
        @uri   = Skype::URI.chat(users)
        @log   = log || Logger.new(STDOUT)
      end

      def open
        Skype::URI.open(@uri)
        @skype.wait_active
        
        @log.info('Finding chat window')
        unless wait_chat_focus
          @log.error('Can\'t find chat window')
          return false
        end
        
        if block_given?
          yield chat_opened?
        else
          chat_opened?
        end
      end

      def send(message)
        text_loc = find_input_area
        
        if text_loc
          @skype.screen.paste(text_loc, message)
          @skype.screen.type(text_loc, Sikulix::Key.ENTER)
        end
      end
      
      private
      
      def wait_chat_focus
        Makina::SikuliUtil::Finder.find_any(
          @skype.screen,
          ['chat_cursor.png', 'chat_cursor2.png'],
          10)
      end

      def find_input_area
        pattern = Sikulix::Pattern.new('clip.png')
        
        if loc = @skype.screen.exists(pattern, 10)
          loc.offset(60, 0)
        else
          nil
        end
      end

      def chat_opened?
        skype_id = @users[0]
        real_skype_id = find_skype_id
        
        @log.info("Checking Skype ID: expected = #{skype_id}, actual = #{real_skype_id}")
        
        skype_id == real_skype_id
      end

      def find_star(star_range = nil)
        star_pattern = Sikulix::Pattern.new('star.png').exact()
        star2_pattern = Sikulix::Pattern.new('star2.png').exact()

        unless star_range
          star_range = @skype.screen
        end

        if star_range.exists(star_pattern, 0.5)
          star_range.find(star_pattern).getTopRight()

        elsif star_range.exists(star2_pattern, 0.5)
          star_range.find(star2_pattern).getTopRight()
        end
      end

      def find_user_name
        star_left_pattern = Sikulix::Pattern.new('star_left.png').exact()
        star_range = @skype.screen.find(star_left_pattern).grow(500)
        star_loc = find_star(star_range)

        star_loc.offset(10, 5)
      end

      def find_skype_id_in_contact_info(contact_pos)
        contact_range = Sikulix::Region.new(@skype.screen).setRect(*contact_pos)
        contact_name_pattern = Sikulix::Pattern.new('contact_name.png').exact()

        contact_range.find(contact_name_pattern)
      end

      def open_contact_window
        name_loc = find_user_name
        @skype.screen.click(name_loc)

        # Wait
        @skype.ahk.skype_wait_contact_info
      end
      
      def close_contact_window
        @skype.ahk.skype_close_contact_info
      end
      
      # Skype のコンタクトウィンドウから Skype ID の場所を探す
      def find_id_pos_in_contact_window
        # x, y, w, h
        contact_pos = @skype.ahk.skype_get_contact_window_pos
        name_in_contact_loc = find_skype_id_in_contact_info(contact_pos)

        [
          name_in_contact_loc.getX + 55,
          name_in_contact_loc.getY -  3,
          contact_pos[2] - (name_in_contact_loc.getX() - contact_pos[0]) - 55,
          21
        ]
      end
      
      def find_skype_id
        open_contact_window
        
        contact_name_pos = find_id_pos_in_contact_window
        contact_name_val_loc =
          Sikulix::Region.new(@skype.screen).setRect(*contact_name_pos)

        skype_id = contact_name_val_loc.text
        
        close_contact_window
        
        return skype_id
      end
    end
  end
end
