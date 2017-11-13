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
            children = document.childNodes().childNodes();
            this.verifyNumElements( children, 2 );
            this.verifyEqual( children(1).Name, 'HEAD' );
            this.verifyEqual( children(2).Name, 'BODY' );
            this.verifyEqual( children(1).parentNode().Name, 'HTML' );
        end
        
    end
    
end