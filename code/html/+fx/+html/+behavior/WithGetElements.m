classdef(Abstract) WithGetElements < ...
        fx.html.behavior.WithEngine
    
    methods( Access = public )
        
        function elements = getElementsByTagName( this, tagName )
            elements = this.Engine.getElementsByTagName( this.Reference, tagName );
        end
        
    end
    
end