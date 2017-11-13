classdef WithEngine < matlab.unittest.TestCase
    
    properties( GetAccess = protected, SetAccess = private )
        Engine(1,1) fx.html.Engine
    end
    
    methods( TestMethodSetup )
        
        function instanciateEngine( this )
            this.Engine = fx.html.Engine();
            pause( 1 )
        end
        
    end
    
end