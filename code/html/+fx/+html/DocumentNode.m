classdef DocumentNode < ...
        fx.html.behavior.Node & ...
        fx.html.behavior.Document & ...
        fx.html.behavior.Element
    
    methods( Access = {?fx.html.Engine} )
        
        function this = DocumentNode( engine, reference )
            this@fx.html.behavior.Node( engine, reference );
        end
        
    end
        
end