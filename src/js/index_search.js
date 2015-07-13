$(function(){
	var basePath="./zhaomei/search.php";
	$("#searchKeyWord").click(function(){
		if($("#keyWordName").val().trim()!=""){location.href=basePath+"?keyWord="+$("#keyWordName").val().trim()}
		});
})