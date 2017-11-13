classdef Element < fx.html.test.WithEngine
    
    methods( Test )
        
        function testGetByTagName( this )
            document = this.Engine.document();
            body = document.getElementsByTagName( 'body' );
            this.verifyNumElements( body, 1 );
            this.verifyEqual( body.Name, 'BODY' );
        end
        
        function testGetByClassName( this )
            document = this.Engine.document();
            body = document.getElementsByClassName( 'stylish' );
            this.verifyNumElements( body, 1 );
            this.verifyEqual( body.Name, 'BODY' );
        end
        
    end
    
end