#!/usr/bin/ruby
# -*- encoding: utf-8 -*-

require_relative './uri'

module Makina
  module Skype
    class Chat
      def initialize(skype, users)
        @skype = skype
        @users = users
        @uri   = Skype::URI.chat(users)
      end

      def open
        Skype::URI.open(@uri)
        @skype.wait_active
        wait_chat_focus
        
        if chat_opened?
          if block_given?
            yield
          else
            true
          end
        else
          false
        end
      end

      def send(message)
        text_loc = find_input_area
        @skype.screen.paste(text_loc, message)
        @skype.screen.type(text_loc, Sikulix::Key.ENTER)
      end
      
      private
      
      def wait_chat_focus
        chat_cursor_pattern = Sikulix::Pattern.new('chat_cursor.png').exact
        @skype.screen.wait(chat_cursor_pattern, 10)
      end

      def find_input_area
        pattern = Sikulix::Pattern.new('clip.png')

        loc = @skype.screen.find(pattern)
        loc.offset(60, 0)
      end

      def chat_opened?
        skype_id = @users[0]
        real_skype_id = parse_skype_id

        p skype_id, real_skype_id
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

      def parse_skype_id
        name_loc = find_user_name
        @skype.screen.click(name_loc)

        # Wait
        @skype.ahk.skype_wait_contact_info

        # x, y, w, h
        contact_pos = @skype.ahk.skype_get_contact_window_pos
        name_in_contact_loc = find_skype_id_in_contact_info(contact_pos)

        contact_name_pos = [
          name_in_contact_loc.getX + 55,
          name_in_contact_loc.getY -  3,
          contact_pos[2] - (name_in_contact_loc.getX() - contact_pos[0]) - 55,
          21
        ]

        contact_name_val_range =
          Sikulix::Region.new(@skype.screen).setRect(*contact_name_pos)

        skype_id = contact_name_val_range.text

        @skype.ahk.skype_close_contact_info
        skype_id
      end
    end
  end
end
