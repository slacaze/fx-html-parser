classdef TextNode < ...
        fx.html.behavior.Node
    
    methods( Access = {?fx.html.Engine} )
        
        function this = TextNode( engine, reference )
            this@fx.html.behavior.Node( engine, reference );
        end
        
    end
        
end