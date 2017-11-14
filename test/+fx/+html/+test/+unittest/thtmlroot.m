classdef thtmlroot < matlab.unittest.TestCase
    
    methods( Test )
        
        function this = testEnhance( this )
            expectedRoot = fileparts( fileparts( fileparts( which( 'fx.html.Engine' ) ) ) );
            this.verifyEqual( htmlroot, expectedRoot );
        end
        
    end
    
end