classdef(Abstract) Node < ...
        fx.html.behavior.WithEngine & ...
        matlab.mixin.Heterogeneous
    
    properties( GetAccess = public, SetAccess = private, Dependent )
        Type (1,1) fx.html.NodeType
        Name (1,:) char
    end
    
    properties( GetAccess = public, SetAccess = public, Dependent )
        Value (1,:) char
    end
    
    methods
        
        function value = get.Type( this )
            value = this.Engine.nodeType( this.Reference );
        end
        
        function value = get.Name( this )
            value = this.Engine.nodeName( this.Reference );
        end
        
        function value = get.Value( this )
            value = this.Engine.nodeValue( this.Reference );
        end
        
        function set.Value( this, value )
            this.Engine.nodeValue( this.Reference, value );
        end
        
    end
    
    methods( Access = public )
        
        function this = Node( engine, reference )
            this@fx.html.behavior.WithEngine( engine, reference )
        end
        
    end
    
    methods( Access = public, Sealed )
        
        function node = parentNode( this )
            node = this.Engine.parentNode( this.Reference );
        end
        
        function nodes = childNodes( this )
            nodes = this.Engine.childNodes( this.Reference );
        end
        
        function decision = isSameNode( this, otherNode )
            validateattributes( this, ...
                {'fx.html.behavior.Node'}, {'scalar'} )
            validateattributes( otherNode, ...
                {'fx.html.behavior.Node'}, {'scalar'} )
            decision = this.Engine.isSameNode( this.Reference, otherNode.Reference );
        end
        
    end
    
    methods( Sealed )
        
        function decision = eq( this, otherNode )
            decision = this.isSameNode( otherNode );
        end
        
    end
    
end