$:.unshift File.dirname(__FILE__)
require 'rubygems'
require "bundler/setup"

require 'radiator'

InformationRadiator::RadiatorApp.define_settings
run InformationRadiator::RadiatorApp