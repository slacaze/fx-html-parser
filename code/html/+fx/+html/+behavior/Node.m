classdef(Abstract) Node < ...
        fx.html.behavior.WithEngine & ...
        matlab.mixin.Heterogeneous
    
    properties( GetAccess = public, SetAccess = private, Dependent )
        Type (1,1) fx.html.NodeType
        Name (1,:) char
    end
    
    methods
        
        function value = get.Type( this )
            value = this.Engine.nodeType( this.Reference );
        end
        
        function value = get.Name( this )
            value = this.Engine.nodeName( this.Reference );
        end
        
    end
    
    methods( Access = public )
        
        function this = Node( engine, reference )
            this@fx.html.behavior.WithEngine( engine, reference )
        end
        
    end
    
    methods( Access = public )
        
        function node = parentNode( this )
            node = this.Engine.parentNode( this.Reference );
        end
        
        function nodes = childNodes( this )
            nodes = this.Engine.childNodes( this.Reference );
        end
        
    end
    
    methods( Sealed )
        
        function varargout = eq( varargin )
            [varargout{1:nargout}] = eq@fx.html.behavior.WithEngine( varargin{:} );
        end
        
    end
    
end