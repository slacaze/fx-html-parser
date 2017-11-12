classdef NodeType < double
    % The available node types
    % https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
    
    enumeration
        ElementNode(1)
        TextNode(3)
        ProcessingInstructionNode(7)
        CommentNode(8)
        DocumentNode(9)
        DocumentTypeNode(10)
        DocumentFragmentNode(11)
    end
    
end