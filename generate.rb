#!/usr/bin/env ruby
require 'byebug'
require 'erb'
require 'ostruct'
require 'fileutils'

FileUtils.rm_rf File.expand_path('commands/*.sh', __dir__)
template = ERB.new File.read(File.expand_path('utm-commands-template.sh', __dir__))

[
  OpenStruct.new(action: 'start'),
  OpenStruct.new(action: 'stop'),
  OpenStruct.new(action: 'restart'),
  OpenStruct.new(action: 'pause'),
  OpenStruct.new(action: 'resume')
].each do |context|
  filename = "utm-#{context.action}"
  # byebug
  path = File.expand_path("commands/#{filename}.sh", __dir__)
  File.open path, 'w' do |f|
    f.write template.result(context.instance_eval { binding } )
  end

  FileUtils.chmod "+x", path
end