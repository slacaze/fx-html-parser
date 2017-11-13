classdef Document < fx.html.test.WithEngine
    
    methods( Test )
        
        function testGetById( this )
            document = this.Engine.document();
            header = document.getElementById( 'header' );
            this.verifyNumElements( header, 1 );
            this.verifyEqual( header.Name, 'H1' );
        end
        
        function testGetByName( this )
            document = this.Engine.document();
            paragraph = document.getElementsByName( 'paragraph' );
            this.verifyNumElements( paragraph, 1 );
            this.verifyEqual( paragraph.Name, 'P' );
        end
        
    end
    
end