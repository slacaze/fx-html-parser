classdef tNodes < fx.html.test.WithEngine
    
    methods( Test )
        
        function testGetDocumentNode( this )
            document = this.Engine.document();
            this.verifyInstanceOf( document, 'fx.html.DocumentNode' );
            this.verifyEqual( document.Name, '#document' );
            this.verifyEqual( document.Type, fx.html.NodeType.DocumentNode );
        end
        
        function testNodeDieOnEngineDeletion( this )
            document = this.Engine.document();
            delete( this.Engine )
            this.verifyFalse( isvalid( document ) );
        end
        
        function testReferenceReleasedOnNodeDeletion( this )
            document = this.Engine.document();
            reference = document.Reference;
            clear document;
            this.verifyError( @() this.Engine.nodeType( reference ), 'FxHtml:UndefinedReference' );
        end
        
        function testDocumentHasNoParent( this )
            document = this.Engine.document();
            this.verifyEmpty( document.parentNode );
        end
        
        function testBasicTree( this )
            document = this.Engine.document();
            children = document.getElementsByTagName( 'html' ).childNodes();
            this.verifyNumElements( children, 3 );
            this.verifyEqual( children(1).Name, 'HEAD' );
            this.verifyEqual( children(3).Name, 'BODY' );
            this.verifyEqual( children(1).parentNode().Name, 'HTML' );
            this.verifyTrue( children(1).parentNode() == children(3).parentNode() );
        end
        
        function testText( this )
            document = this.Engine.document();
            text = document.getElementById( 'hardstuff' ).childNodes();
            this.verifyNumElements( text, 1 );
            this.verifyEqual( text.Value, 'Difficult %^& with "char" <all over> the place' )
        end
        
    end
    
end