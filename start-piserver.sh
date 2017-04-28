#!/bin/sh
bundle exec ruby app.rb -o 0.0.0.0 &
bundle exec ruby post_service.rb &
