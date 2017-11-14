classdef Engine < handle
    
    properties( GetAccess = public, SetAccess = public, AbortSet, Dependent )
        HTML (1,:) char
        Visible (1,1) logical
    end
    
    properties( GetAccess = public, SetAccess = private )
        NodeCounter (1,1) double = 0
    end
    
    properties( GetAccess = public, SetAccess = immutable )
        Browser matlab.internal.webwindow
    end
    
    methods
        
        function value = get.HTML( this )
            value = this.outerHTML( 'document.documentElement' );
        end
        
        function set.HTML( this, value )
            this.innerHTML( 'document.documentElement', value );
        end
        
        function value = get.Visible( this )
            value = this.Browser.isVisible();
        end
        
        function set.Visible( this, value )
            if value
                this.Browser.show();
                this.Browser.bringToFront();
            else
                this.Browser.hide();
            end
        end
        
    end
    
    methods( Access = public )
        
        function this = Engine( url )
            if nargin < 1
                url = 'about:blank';
            end
            this.Browser = matlab.internal.webwindow( url );
            this.waitForReadyState();
        end
        
        function delete( this )
            delete( this.Browser );
        end
        
    end
    
    methods( Access = public )
        
        function nodeReference = document( this )
            nodeReference = this.createNodeReference( 'document' );
        end
        
        function type = nodeType( this, reference )
            typeId = this.js( '%s.nodeType', reference );
            type = fx.html.NodeType( typeId );
        end
        
        function name = nodeName( this, reference )
            name = this.js( '%s.nodeName', reference );
        end
        
        function value = nodeValue( this, reference, value )
            if nargin < 3
                % Get
                value = this.js( '%s.nodeValue', reference );
            else
                % Set
                value = this.js( '%s.nodeValue = %s', reference, value );
            end
        end
        
        function html = innerHTML( this, reference, value )
            if nargin < 3
                % Get
                html = this.js( '%s.innerHTML', reference );
            else
                % Set
                html = this.js( '%s.innerHTML = %s', reference, value );
            end
        end
        
        function html = outerHTML( this, reference, value )
            if nargin < 3
                % Get
                html = this.js( '%s.outerHTML', reference );
            else
                % Set
                html = this.js( '%s.outerHTML = %s', reference, value );
            end
        end
        
        function node = parentNode( this, reference )
            this.js( 'tempNode = %s.parentNode', ...
                reference );
            node = this.createNodeReference( 'tempNode' );
            this.releaseJavaScriptReference( 'tempNode' );
        end
        
        function nodes = childNodes( this, reference )
            this.js( 'nodeList = %s.childNodes', ...
                reference );
            nodes = this.createNodeReferences( 'nodeList' );
            this.releaseJavaScriptReference( 'nodeList' );
        end
        
        function decision = isSameNode( this, firstReference, SecondReference )
            decision = this.js( '%s.isSameNode( %s )', ...
                firstReference, SecondReference );
        end
        
        function element = getElementById( this, reference, id )
            this.js( 'element = %s.getElementById( "%s" )', ...
                reference, id );
            element = this.createNodeReference( 'element' );
            this.releaseJavaScriptReference( 'element' );
        end
        
        function element = getElementsByName( this, reference, name )
            this.js( 'elementList = %s.getElementsByName( "%s" )', ...
                reference, name );
            element = this.createNodeReferences( 'elementList' );
            this.releaseJavaScriptReference( 'elementList' );
        end
        
        function elements = getElementsByTagName( this, reference, tagName )
            this.js( 'elementList = %s.getElementsByTagName( "%s" )', ...
                reference, tagName );
            elements = this.createNodeReferences( 'elementList' );
            this.releaseJavaScriptReference( 'elementList' );
        end
        
        function elements = getElementsByClassName( this, reference, className )
            this.js( 'elementList = %s.getElementsByClassName( "%s" )', ...
                reference, className );
            elements = this.createNodeReferences( 'elementList' );
            this.releaseJavaScriptReference( 'elementList' );
        end
        
    end
    
    methods( Access = {?fx.html.behavior.WithEngine} )
        
        function releaseJavaScriptReference( this, reference )
            this.js( 'delete %s', reference );
        end
        
    end
    
    methods( Access = private )
        
        function ref = newReference( this )
            ref = sprintf( 'FxHtmlRef_%d', this.NodeCounter );
            this.NodeCounter = this.NodeCounter + 1;
        end
        
    end
    
    methods( Access = private )
        
        function waitForReadyState( this )
            ready = false;
            while ~ready
                try
                    document = this.document(); %#ok<NASGU>
                    ready = true;
                catch
                    pause( 0.01 );
                end
            end
        end
        
        function varargout = js( this, varargin )
            try
                output = this.Browser.executeJS( sprintf( varargin{:} ) );
            catch matlabException
                % There an inconsequential error for which we give a pass
                ignoreException = ...
                    strcmp( matlabException.identifier, 'cefclient:webwindow:jserror' ) && ...
                    ~isempty( regexp( matlabException.message, 'Uncaught TypeError: Converting circular structure to JSON at line 0 column -1 in undefined', 'once' ) );
                if ~ignoreException
                    % Let's try to have better error tracking
                    reference = regexp( ...
                        matlabException.message, ...
                        'Uncaught ReferenceError: (FxHtmlRef_[0-9]*) is not defined', ...
                        'once', ....
                        'tokens' );
                    isReferenceError = ~isempty( reference );
                    if isReferenceError
                        newException = MException( ...
                            'FxHtml:UndefinedReference', ...
                            'The reference "%s" is undefined.', ...
                            reference{1} );
                        newException.addCause( matlabException );
                        newException.throw();
                    else
                        matlabException.rethrow();
                    end
                end
            end
            if nargout > 0
                % Try if it's a number
                outputNumeric = str2double( output );
                if ~isnan( outputNumeric )
                    output = outputNumeric;
                else
                    % Try for boolean
                    if strcmp( output, 'true' )
                        output = true;
                    elseif strcmp( output, 'false' )
                        output = false;
                    else
                        % Not boolean, remove quotes
                        if output(1) == '"' && output(end) == '"'
                            output = fx.html.util.unescapeJavaScriptString( output(2:end-1) );
                        end
                    end
                end
                varargout{1} = output;
            end
        end
        
        function nodes = createNodeReferences( this, listReference )
            nodes = fx.html.behavior.Node.empty;
            nElements = this.js( '%s.length', listReference );
            for nodeIndex = 1:nElements
                this.js( 'tempNode = %s[%d]', ...
                    listReference, nodeIndex - 1);
                nodes(nodeIndex) = this.createNodeReference( 'tempNode' );
            end
            if nElements > 0
                this.releaseJavaScriptReference( 'tempNode' );
            end
        end
        
        function node = createNodeReference( this, tempReference )
            permanentReference = this.newReference;
            thisNode = this.js( '%s = %s', permanentReference, tempReference );
            if ischar( thisNode ) && strcmp( thisNode, 'null' )
                node = fx.html.behavior.Node.empty;
            else
                switch this.nodeType( permanentReference )
                    case fx.html.NodeType.ElementNode
                        node = fx.html.ElementNode( this, permanentReference );
                    case fx.html.NodeType.TextNode
                        node = fx.html.TextNode( this, permanentReference );
                    case fx.html.NodeType.DocumentNode
                        node = fx.html.DocumentNode( this, permanentReference );
                    case fx.html.NodeType.DocumentTypeNode
                        node = fx.html.DocumentTypeNode( this, permanentReference );
                    otherwise
                        error( ...
                            'FxHtml:NotImplemented', ...
                            'Constructor for node type "%s" not yet implemented.', ...
                            this.nodeType( permanentReference ) );
                end
            end
        end
        
    end
    
end