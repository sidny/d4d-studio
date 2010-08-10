function LOADJS(urls, callback, charset) {
	// type checking functions
	function isFunction(obj) {
		return Object.prototype.toString.call(obj) === "[object Function]";
	}

	function isArray(obj) {
		return Object.prototype.toString.call(obj) === "[object Array]";
	}

	function isString(obj) {
		return typeof obj == "string" || Object.prototype.toString.call(obj) === "[object String]";
	}

	// callback for js queue loading
	var i = 0;
	function success() {
		if (i < urls.length) {
			loadjs(urls[i++], success, charset);
		}
		else {
			if (isFunction(callback)) {
				callback();
			}
		}
	}

	// inner function for loading a single js file
	function loadjs(url, callback, charset) {
		if (isString(callback)) {
			charset = callback;
		}

		var head = document.getElementsByTagName("head")[0];
		var script = document.createElement("script");
		if (charset) {
			script.charset = charset;
		}
		script.src = url;

		// Handle Script loading
		var done = false;
		// Attach handlers for all browsers
		script.onload = script.onreadystatechange = function(){
			if ( !done && (!this.readyState ||
					this.readyState == "loaded" || this.readyState == "complete") ) {
				done = true;
				if (isFunction(callback)) {
					callback();
				}
				// Handle memory leak in IE
				script.onload = script.onreadystatechange = null;
				head.removeChild( script );
			}
		};

		head.appendChild(script);
	};

	// use different way to load js or js array
	if (isString(urls)) {
		loadjs(urls, callback, charset);
	}
	else if (isArray(urls)) {
		loadjs(urls[i++], success, charset);
	}
}
