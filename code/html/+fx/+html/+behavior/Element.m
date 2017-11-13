classdef(Abstract) Element < ...
        fx.html.behavior.WithEngine
    
    methods( Access = public, Sealed )
        
        function elements = getElementsByClassName( this, className )
            elements = this.Engine.getElementsByClassName( this.Reference, className );
        end
        
        function elements = getElementsByTagName( this, tagName )
            elements = this.Engine.getElementsByTagName( this.Reference, tagName );
        end
        
    end
    
end