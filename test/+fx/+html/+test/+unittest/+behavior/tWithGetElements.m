classdef tWithGetElements < fx.html.test.WithEngine
    
    methods( Test )
        
        function testGetByTagName( this )
            document = this.Engine.document();
            body = document.getElementsByTagName( 'body' );
            this.verifyNumElements( body, 1 );
            this.verifyEqual( body.Name, 'BODY' );
        end
        
    end
    
end