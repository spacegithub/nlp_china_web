<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>Markdown Editor</title>
	<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
	<script src="${ctx}/document/js/marked.js"></script>
	<script src="${ctx}/document/js/highlight.pack.js"></script>
	<script src="${ctx}/document/codemirror/lib/codemirror.js"></script>
	<script src="${ctx}/document/codemirror/xml/xml.js"></script>
	<script src="${ctx}/document/codemirror/markdown/markdown.js"></script>
	<script src="${ctx}/document/codemirror/gfm/gfm.js"></script>
	<script src="${ctx}/document/codemirror/javascript/javascript.js"></script>
	<script src="${ctx}/document/rawinflate.js"></script>
	<script src="${ctx}/document/rawdeflate.js"></script>
	<link rel="stylesheet" href="${ctx}/document/codemirror/lib/codemirror.css">
  <style>
    .CodeMirror pre{
      line-height: 14px;
    }
    #in, .CodeMirror{
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      width: 50%;
      overflow: auto;
      font-size: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    }
    .CodeMirror-scroll {
      height: 100%;
      min-height: 100%;
    }

    #out{
      position: fixed;
      top: 0;
      right: 0;
      left: 50%;
      bottom: 0;
      overflow: auto;
      padding: 10px;
      padding-left: 20px;
      color: #444;
      font-family:Georgia, Palatino, 'Palatino Linotype', Times, 'Times New Roman', serif;
      font-size: 16px;
      line-height: 1.5em
    }

    @media screen and (max-width: 1024px) {
      #in {
        display: none;
      }
      #out {
        left: 0;
        padding-left: 10px;
      }
    }

    .view #in {
      display: none;
    }
    .view #out {
      left: 0;
      padding-left: 10px;
    }

    a{ color: #0645ad; text-decoration:none;}
    a:visited{ color: #0b0080; }
    a:hover{ color: #06e; }
    a:active{ color:#faa700; }
    a:focus{ outline: thin dotted; }
    a:hover, a:active{ outline: 0; }

    p{margin:1em 0;}

    img{max-width:100%;}

    h1,h2,h3,h4,h5,h6{font-weight:normal;color:#111;line-height:1em;}
    h4,h5,h6{ font-weight: bold; }
    h1{ font-size:2.5em; }
    h2{ font-size:2em; border-bottom:1px solid silver; padding-bottom: 5px; }
    h3{ font-size:1.5em; }
    h4{ font-size:1.2em; }
    h5{ font-size:1em; }
    h6{ font-size:0.9em; }

    blockquote{color:#666666;margin:0;padding-left: 3em;border-left: 0.5em #EEE solid;}
    hr { display: block; height: 2px; border: 0; border-top: 1px solid #aaa;border-bottom: 1px solid #eee; margin: 1em 0; padding: 0; }

    pre, code{
      color: #000;
      font-family: monospace;
      font-size: 0.88em;
      border-radius:3px;
      background-color: #F8F8F8;
      border: 1px solid #CCC;
    }
    pre { white-space: pre; white-space: pre-wrap; word-wrap: break-word; padding: 5px;}
    pre code { border: 0px !important; background: transparent !important; line-height: 1.3em; }
    code { padding: 0 3px 0 3px; }
    sub, sup { font-size: 75%; line-height: 0; position: relative; vertical-align: baseline; }
    sup { top: -0.5em; }
    sub { bottom: -0.25em; }
    ul, ol { margin: 1em 0; padding: 0 0 0 2em; }
    li p:last-child { margin:0 }
    dd { margin: 0 0 0 2em; }
    img { border: 0; -ms-interpolation-mode: bicubic; vertical-align: middle; }
    table { border-collapse: collapse; border-spacing: 0; }
    td, th { vertical-align: top; padding: 4px 10px; border: 1px solid #bbb; }
    tr:nth-child(even) td, tr:nth-child(even) th { background: #eee; }
  </style>
</head>
<body>
  <div id="in"><form><textarea id="code">aaa</textarea></form></div>
  <div id="out"></div>

  <script>
  
  	$('#code').val(parent.window.document.getElementById('document.content').value) ;
  
    var URL = window.URL || window.webkitURL || window.mozURL || window.msURL;
    navigator.saveBlob = navigator.saveBlob || navigator.msSaveBlob || navigator.mozSaveBlob || navigator.webkitSaveBlob;
    window.saveAs = window.saveAs || window.webkitSaveAs || window.mozSaveAs || window.msSaveAs;

    // Because highlight.js is a bit awkward at times
    var languageOverrides = {
      js: 'javascript',
      html: 'xml'
    }

    marked.setOptions({
      highlight: function(code, lang){
        if(languageOverrides[lang]) lang = languageOverrides[lang];
        return hljs.LANGUAGES[lang] ? hljs.highlight(lang, code).value : code;
      }
    });

    function update(e){
      var val = e.getValue();
      setOutput(val);
      clearTimeout(hashto);
      hashto = setTimeout(updateHash, 1000);
    }

    function setOutput(val){

      val = val.replace(/<equation>((.*?\n)*?.*?)<\/equation>/ig, function(a, b){
        return '<img src="http://latex.codecogs.com/png.latex?' + encodeURIComponent(b) + '" />';
      });

      $('#code').val(val) ;
      
      document.getElementById('out').innerHTML = marked(val);
    }

    var editor = CodeMirror.fromTextArea(document.getElementById('code'), {
      mode: 'gfm',
      lineNumbers: true,
      matchBrackets: true,
      lineWrapping: true,
      theme: 'default',
      onChange: update
    });

    document.addEventListener('drop', function(e){
      e.preventDefault();
      e.stopPropagation();

      var theFile = e.dataTransfer.files[0];
      var theReader = new FileReader();
      theReader.onload = function(e){
        editor.setValue(e.target.result);
      };

      theReader.readAsText(theFile);
    }, false);

    function save(){
      var code = editor.getValue();
      var blob = new Blob([code], { type: 'text/plain' });
      saveBlob(blob);
    }

    function saveBlob(blob){
      var name = "untitled.md";
      if(window.saveAs){
        window.saveAs(blob, name);
      }else if(navigator.saveBlob){
        navigator.saveBlob(blob, name);
      }else{
        url = URL.createObjectURL(blob);
        var link = document.createElement("a");
        link.setAttribute("href",url);
        link.setAttribute("download",name);
        var event = document.createEvent('MouseEvents');
        event.initMouseEvent('click', true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null);
        link.dispatchEvent(event);
      }
    }

    document.addEventListener('keydown', function(e){
      if(e.keyCode == 83 && (e.ctrlKey || e.metaKey)){
        e.preventDefault();
        save();
        return false;
      }
    })

    var hashto;

    function updateHash(){
      window.location.hash = btoa(RawDeflate.deflate(unescape(encodeURIComponent(editor.getValue()))))
    }

    if(window.location.hash){
      var h = window.location.hash.replace(/^#/, '');
      if(h.slice(0,5) == 'view:'){
        setOutput(decodeURIComponent(escape(RawDeflate.inflate(atob(h.slice(5))))));
        document.body.className = 'view';
      }else{
        editor.setValue(decodeURIComponent(escape(RawDeflate.inflate(atob(h)))))
        update(editor);
        editor.focus();
      }
    }else{
      update(editor);
      editor.focus();
    }
    
	
  </script>
</body>
</html>
