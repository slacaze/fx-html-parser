function code = unescapeJavaScriptString(code)
    %unescapeJavaScriptString Parse a JavaScript string.
    %   unescapeJavaScriptString(S) manually interprets a JavaScript string,
    %   which may contain escape characters.  This is sometimes useful when
    %   scraping HTML.
    
    % Matthew J. Simoneau, January 2009
    % Copyright 2009 The MathWorks, Inc.
    
    code = strrep(code,'\\','THIS_IS_ESCAPED_DUDE');
    code = strrep(code,'\b',char(8));
    code = strrep(code,'\f',char(12));
    code = strrep(code,'\n',char(10));
    code = strrep(code,'\0',char(0));
    code = strrep(code,'\r',char(13));
    code = strrep(code,'\t',char(9));
    code = strrep(code,'\v',char(11));
    code = strrep(code,'\''','''');
    code = strrep(code,'\"','"');
    code = regexprep(code, ...
        '\\(\d{3})', ...
        '${native2unicode(base2dec($1,8),''latin1'')}');
    code = regexprep(code, ...
        '\\x([0-9A-Fa-f]{2})', ...
        '${native2unicode(base2dec($1,16),''latin1'')}');
    code = regexprep(code, ...
        '\\u([0-9A-Fa-f]{4})', ...
        '${char(base2dec($1,16))}');
    code = strrep(code,'THIS_IS_ESCAPED_DUDE','\');
end