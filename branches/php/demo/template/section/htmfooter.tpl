<script type="text/javascript" src="<{'/core/js/others/loader/loader.js'|formaturl}>"></script>
<script type="text/javascript">
window.ENVOBJ = <{$envobj}>;
LOADJS(<{jsholder output="1"}><{/jsholder}>, function() {
	$.domains = window.ENVOBJ.domains;
	$.getScript(window.ENVOBJ.domains.www + '/user/data.js');
	if(typeof(window[window.ENVOBJ['onload']]) == 'function'){
		window[window.ENVOBJ.onload](); 
	}
});
</script>
<{scriptholder output=1}><{/scriptholder}>
<script type="text/javascript">
var _gaq = _gaq || [];
_gaq.push(
        ['_setAccount', 'UA-7350761-2'],
        ['_setDomainName', '.139.com'],
        ['_trackPageview']
);

(function() {
 var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
 ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
 (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);
})();
</script>
<script>window.systemNotice=<{$system_notice}>;</script>
<script>var _bi_src="sq", _bi_uid="<{$current_user_id}>";</script>
<script src="<{'bi/report_stat.js'|formaturl}>"></script>
</body>
</html>

