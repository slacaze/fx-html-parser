classdef tNodes < matlab.unittest.TestCase
    
    properties( GetAccess = private, SetAccess = private )
        Engine(1,1) fx.html.Engine
    end
    
    methods( TestMethodSetup )
        
        function instanciateEngine( this )
            this.Engine = fx.html.Engine();
            pause( 1 )
        end
        
    end
    
    methods( Test )
        
        function testGetDocumentNode( this )
            document = this.Engine.document();
            this.verifyInstanceOf( document, 'fx.html.DocumentNode' );
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
        
    end
    
end