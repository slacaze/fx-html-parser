classdef(Abstract) WithEngine < handle
    
    properties( GetAccess = protected, SetAccess = immutable )
        Engine fx.html.Engine
    end
    
    properties( GetAccess = public, SetAccess = immutable, Hidden )
        Reference char
    end
    
    properties( GetAccess = private, SetAccess = immutable )
        EngineDeletionListener event.listener
    end
    
    methods( Access = public )
        
        function this = WithEngine( engine, reference )
            if nargin ~= 0
                this.Engine = engine;
                this.Reference = reference;
                this.EngineDeletionListener = event.listener( this.Engine,...
                    'ObjectBeingDestroyed', @(~,~) this.delete() );
            end
        end
        
        function delete( this )
            this.Engine.releaseJavaScriptReference( this.Reference );
        end
        
    end
    
end