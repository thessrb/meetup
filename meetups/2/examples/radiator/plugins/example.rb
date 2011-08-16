$:.unshift File.join(File.dirname(__FILE__),"..","..")

module InformationRadiator
  module Plugins
    #Provides the binding for the canvas template when showing information about current issues
    class Example
      def initialize cfg
        @refresh=cfg[:settings][:refresh]*1000 if cfg[:settings]
        @refresh||=30
      end
      
      #provides the js function call to use when drawing the canvas contents
      #
      #It will query the database for the current work item information 
      #and display the iteration name and the number of open, closed and blocked issues.
      def drawing_function
        #get the last entry
        func="example(#{@refresh})"
        return func
      end
    end
  end
end