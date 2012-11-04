#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
require "rubypython"

RubyPython.start

puts 'Pythonのクラスを呼び出す'
cPickle = RubyPython.import("cPickle")
p cPickle.dumps("Testing RubyPython.").rubify

puts 'Pythonの自作メソッドを呼び出す'
dir = File.dirname(__FILE__)
sys = RubyPython.import 'sys'
sys.path.append File.join(dir, '.')
called_ruby = RubyPython.import("called_ruby")
called_ruby.print_python

puts called_ruby.print_python_with_argument!( arg1: "Ruby String" ).rubify
puts called_ruby.print_python_with_argument!( arg1: 1234 ).rubify

RubyPython.stop
