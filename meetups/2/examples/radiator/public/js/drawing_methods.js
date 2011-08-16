//fills text in the given coordinates.
//if color, or font are null the current color or font of the 
//context is used
function printText(msg,x,y,ctx,color,font)
{
	if (color != null)
	{
		ctx.fillStyle= color;
	}
	if (font!=null)
	{
		ctx.font=font
	}
	ctx.fillText(msg,x,y)
}
//Brings up an error message under the title heading
function error(title,msg,timeout)
{
	var canvas = document.getElementById('canvas'); 
	var ctx = canvas.getContext('2d');
	
	var width = document.documentElement.clientWidth;
	var height = document.documentElement.clientHeight;
	canvas.width=width-16
	canvas.height=height-23
	ctx.save();
	//background
	ctx.fillStyle = 'black';
	ctx.fillRect(0, 0, width, height);
	//the title
	printText(title,30,50,ctx,'orange',"25pt Sanserif");
	//change coordinates to bring 0,0 in the center left
	ctx.translate(0, height/2);
	//the message
	printText(msg,100,0,ctx,"red","20pt Verdana");
	//refresh
	setTimeout("location.reload(true);",timeout)
}

function example(timeout)
{
	var canvas = document.getElementById('canvas'); 
	var ctx = canvas.getContext('2d');
	
	var width = document.documentElement.clientWidth;
	var height = document.documentElement.clientHeight;
	canvas.width=width-16
	canvas.height=height-23
	ctx.save();
	//background
	ctx.fillStyle = 'black';
	ctx.fillRect(0, 0, width, height);
	
	printText("Refresh in "+timeout,50,200,ctx,'orange',"25pt Sanserif");
	//refresh
	setTimeout("location.reload(true);",timeout)
}