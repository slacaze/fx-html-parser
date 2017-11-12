function thisPath = htmlroot()
    % Root of the Fx HTML Parser Toolbox
    %
    %   path = htmlroot() return the root of the Fx HTML Parser Toolbox in
    %   the "path" variable.
    
    thisPath = fileparts( mfilename( 'fullpath' ) );
end