classdef(Abstract) Document < ...
        fx.html.behavior.WithEngine
    
    methods( Access = public, Sealed )
        
        function elements = getElementById( this, id )
            elements = this.Engine.getElementById( this.Reference, id );
        end
        
        function elements = getElementsByName( this, name )
            elements = this.Engine.getElementsByName( this.Reference, name );
        end
        
    end
    
end