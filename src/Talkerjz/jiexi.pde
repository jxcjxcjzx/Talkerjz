class jiexi {	
	String forcompile = null;
	java.util.regex.Pattern p = null;
	Matcher m = null;
	
	jiexi(String a)
	{
		this.p = java.util.regex.Pattern.compile(a);
	}
	
	boolean whethermatch(String formatch)
	{
		boolean forreturn = false;
		Matcher tomatch = this.p.matcher(formatch);
		if(tomatch.matches()){
		  forreturn = true;
		}
		return forreturn;
	}
	
	String replacetags(String forjiexi)
	{
		String forreturn = null;
		java.util.regex.Pattern newp = java.util.regex.Pattern.compile("<.+?>");
		Matcher newm = newp.matcher(forjiexi);
		forreturn = newm.replaceAll("");
		return forreturn;
	}
}

