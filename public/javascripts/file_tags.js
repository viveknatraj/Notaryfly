//upload more files

//upload more files
var xmlHttp
	var fileId = 1;
	function addElement(parentId, elementTag, elementId, html)
	{
		var p = document.getElementById(parentId);
		var newElement = document.createElement(elementTag);
		newElement.setAttribute('id', elementId);
		newElement.innerHTML = html;
		//alert(html);
		p.appendChild(newElement);
	}

	function removeElement(elementId)
	{
		var element = document.getElementById(elementId);
		element.parentNode.removeChild(element);

        var val= document.getElementById("totfile").value;
        var id = elementId.replace(/^.+?_(\d+).+?$/, "$1");
        document.getElementById("totfile").value = val.replace(id,"").replace(",,",",");

        fileId--;
        var nodes = document.getElementById('ItemFiles').childNodes;
            for(i=1; i<nodes.length+1; i++) {
                countId = i;

                var html="Add : ";
                html = html+"<input id=\"order_attachment_"+countId+"\" type=\"file\" name=\"order[order_attachment_"+countId+"]\" size=\"30\"/>" +
                    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'order[order_attachment_' + countId + ']\'); return false;"><span class="removebro">Remove</span></a>'  + " (" + countId + " of " + 6 + ") ";
                if (nodes[countId-1].id == elementId ) {
                    addElement('ItemFiles', 'p', 'order[order_attachment_' + countId +']', html);
                } else {
                    nodes[countId-1].setAttribute("id", "order[order_attachment_" + countId + "]");
                    nodes[countId-1].innerHTML = html;
                }
            }

		if(fileId<6)
		{
//			document.getElementById('uploadlink').style.display = '';
            document.getElementById('attachment_count-error').innerHTML = '';
        }
	}

        function removeElement2(elementId,id)
	{
		var element = document.getElementById(elementId);
		element.parentNode.removeChild(element);

                fileId--;
		if(fileId<6)
		{
            uploadlink = document.getElementById('uploadlink');
            if (uploadlink) {
                document.getElementById('uploadlink').style.display = '';
            }
		}

                var val= document.getElementById("totfile").value;
                document.getElementById("totfile").value = val.replace(","+id,"");
	}

	function addFile()
	{
             var existfile = document.getElementById("totfile").value;
            
             var myfile_array=existfile.split(",");
             var arr2str = myfile_array.toString();

             fileId++;

             if(arr2str.length!=0)
             {
                      if(!myfile_array.contains("2"))
                             {
                                document.getElementById("totfile").value = document.getElementById("totfile").value+",2";

                                 fileTagAdd(2);
                                
                             }
                          else if(!myfile_array.contains("3"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",3";

                                 fileTagAdd(3);
                            
                             }
                          else if(!myfile_array.contains("4"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",4";

                                 fileTagAdd(4);
                            
                             }
                          else if(!myfile_array.contains("5"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",5";

                                 fileTagAdd(5);
                               
                             }
                          else if(!myfile_array.contains("6"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",6";

                                 fileTagAdd(6);
                             
                             }
             }
             else
             {

             var html="Add : ";
		html = html+"<input id=\"client_attachment_"+fileId+"\" type=\"file\" name=\"client[attachment_"+fileId+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'client[attachment_' + fileId + ']\'); return false;"><span class="removebro">Remove</span></a>'  + " (" + fileId + " of " + 6 + ") ";

                addElement('ItemFiles', 'p', 'client[attachment_' + fileId+']', html);

                if(fileId==6)
                    uploadlink = document.getElementById('uploadlink');
                 if (uploadlink) {
                     document.getElementById('uploadlink').style.display = 'none';
                 }
             }
             
             var finalTotFile = document.getElementById("totfile").value;
             var finalTotFileArr = finalTotFile.split(",");
            
if(finalTotFileArr.length==6)
    {
        uploadlink = document.getElementById('uploadlink');
        if (uploadlink) {
            document.getElementById('uploadlink').style.display = 'none';
        }
    }

		}




function fileTagAdd(id)
{
     var html="Add : ";
		html = html+"<input id=\"client_attachment_"+id+"\" type=\"file\" name=\"client[attachment_"+id+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement2(\'client[attachment_' + id + ']\',\'' + id + '\'); return false;"><span class="removebro">Remove</span></a>';
           return addElement('ItemFiles', 'p', 'client[attachment_' + id+']', html);
}


Array.prototype.contains = function (element) {
for (var i = 0; i < this.length; i++) {
if (this[i] == element) {
return true;
}
}
return false;
}



function addFileForOrders()
	{
		fileId++;
		 var html="Add : ";
		html = html+"<input id=\"order_attachment_"+fileId+"\" type=\"file\" name=\"order[order_attachment_"+fileId+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'order[order_attachment_' + fileId + ']\'); return false;"><span class="removebro">Remove</span></a>';

                addElement('ItemFiles', 'p', 'order[order_attachment_' + fileId+']', html);
                if(fileId==6)
                    uploadlink = document.getElementById('uploadlink');
        if (uploadlink) {
            document.getElementById('uploadlink').style.display = 'none';
        }
		}



function addFileForOrdersEdit()
	{
             var existfile = document.getElementById("totfile").value;

             var myfile_array=existfile.split(",");
             var arr2str = myfile_array.toString();

             if(arr2str.length!=0)
             {
                      if(!myfile_array.contains("2"))
                             {
                                document.getElementById("totfile").value = document.getElementById("totfile").value+",2";

                                 fileTagAddForOrderEdit(2);

                             }
                          else if(!myfile_array.contains("3"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",3";

                                 fileTagAddForOrderEdit(3);

                             }
                          else if(!myfile_array.contains("4"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",4";

                                 fileTagAddForOrderEdit(4);

                             }
                          else if(!myfile_array.contains("5"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",5";

                                 fileTagAddForOrderEdit(5);

                             }
                          else if(!myfile_array.contains("6"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",6";

                                 fileTagAddForOrderEdit(6);

                             }
             }
             else
             {

             var html="Add : ";
		html = html+"<input id=\"order_attachment_"+fileId+"\" type=\"file\" name=\"order[order_attachment_"+fileId+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'order[order_attachment_' + fileId + ']\'); return false;"><span class="removebro">Remove</span></a>' + " (" + fileId + " of " + 6 + ") ";

                addElement('ItemFiles', 'p', 'order[order_attachment_' + fileId+']', html);
                 document.getElementById("totfile").value = "1";

                if(fileId==6)
                    var uploadlink = document.getElementById('uploadlink');
                 if (uploadlink) {
                     document.getElementById('uploadlink').style.display = 'none';
                 }
             }
        if ((fileId > 5) || (arr2str.length > 5)) {
            document.getElementById('attachment_count-error').innerHTML = 'Maximum 6 attachment files can upload';
        }

             var finalTotFile = document.getElementById("totfile").value;
             var finalTotFileArr = finalTotFile.split(",");

if(finalTotFileArr.length==6)
    {

        uploadlink = document.getElementById('uploadlink');
        if (uploadlink) {
            document.getElementById('uploadlink').style.display = 'none';
        }
    }

        fileId++;

		}


function fileTagAddForOrderEdit(id)
{

    var html="Add : ";

//		html = html+"<input id=\"order_attachment_"+id+"\" type=\"file\" name=\"order[order_attachment_"+id+"]\" size=\"30\"/>" +
//	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeFile(\'order[order_attachment_' + id + ']\',\'' + id + '\'); return false;"><span class="removebro">Remove</span></a>'  + " (" + id + " of " + 6 + ") ";

		html = html+"<input id=\"order_attachment_"+id+"\" type=\"file\" name=\"order[order_attachment_"+id+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'order[order_attachment_' + id + ']\')"><span class="removebro">Remove</span></a>'  + " (" + id + " of " + 6 + ") ";

           return addElement('ItemFiles', 'p', 'order[order_attachment_' + id+']', html);
}


function fileTagDummy(id)
{
     var html="Add : ";
		html = html+"<input id=\"order_attachment_"+id+"\" type=\"file\" name=\"order[order_attachment_"+id+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeFile(\'order[order_attachment_' + id + ']\',\'' + id + '\'); return false;"></a>'  + " (" + id + " of " + 6 + ") ";
           return addElement('ItemFiles', 'p', 'order[order_attachment_' + id+']', html);
}


function removeFile(elementId,id)
	{
            
                if(elementId == "order[order_attachment_1]")
                {
                document.new_order_form.fileName1.value = "";
                document.new_order_form.fileUrl1.value = "";
                }

                if(elementId == "order[order_attachment_2]")
                {
                document.new_order_form.fileName2.value = "";
                document.new_order_form.fileUrl2.value = ""
                }

                if(elementId == "order[order_attachment_3]")
                {
                document.new_order_form.fileName3.value = ""
                document.new_order_form.fileUrl3.value = ""
                }

                if(elementId == "order[order_attachment_4]")
                {
                document.new_order_form.fileName4.value = ""
                document.new_order_form.fileUrl4.value = ""
                }

                if(elementId == "order[order_attachment_5]")
                {
                document.new_order_form.fileName5.value = ""
                document.new_order_form.fileUrl5.value = ""
                }

                if(elementId == "order[order_attachment_6]")
                {
                document.new_order_form.fileName6.value = ""
                document.new_order_form.fileUrl6.value = ""
                }

        var val= document.getElementById("totfile").value;
        document.getElementById("totfile").value = val.replace(id,"").replace(",,",",");

            if(elementId == "order[order_attachment_1]")
                fileTagDummy(id)
        var element = document.getElementById(elementId);
        element.parentNode.removeChild(element);

        fileId--;
        document.getElementById('attachment_count-error').innerHTML = '';

		if(fileId<6)
		{
            uploadlink = document.getElementById('uploadlink');
            if (uploadlink) {
                uploadlink.style.display = '';
            }
		}

	}



function addSigner2()
{
   var imgPath = document.getElementById('addsigner').src;
   var val = imgPath.search("add_signer.jpg");
   
   if(val!=-1)
        {
    document.getElementById("signer2").style.display="";
    var rm_signerPath = imgPath.replace("add_signer.jpg","remove_signer.jpg")
     document.getElementById('addsigner').src=rm_signerPath;
         }
        else
            {
               document.getElementById("signer2").style.display="none";
               var rm_signerPath = imgPath.replace("remove_signer.jpg","add_signer.jpg")
               document.getElementById('addsigner').src=rm_signerPath;      
            }
}

function testT()
{
    //alert(document.getElementById("tt").value);
}

/* var xmlHttp
	var fileId = 1;
	function addElement(parentId, elementTag, elementId, html)
	{
		var p = document.getElementById(parentId);
		var newElement = document.createElement(elementTag);
		newElement.setAttribute('id', elementId);
		newElement.innerHTML = html;
		//alert(html);
		p.appendChild(newElement);
	}

	function removeElement(elementId)
	{
		var element = document.getElementById(elementId);
		element.parentNode.removeChild(element);
                fileId--;
		if(fileId<6)
		{
			document.getElementById('uploadlink').style.display = '';
		}
	}

        function removeElement2(elementId,id)
	{
		var element = document.getElementById(elementId);
		element.parentNode.removeChild(element);
                
                fileId--;
		if(fileId<6)
		{
			document.getElementById('uploadlink').style.display = '';
		}
                
                var val= document.getElementById("totfile").value;
                document.getElementById("totfile").value = val.replace(id,"");
	}

	function addFile()
	{
             var existfile = document.getElementById("totfile").value;
             var myfile_array=existfile.split(",");
             var arr2str = myfile_array.toString();
            
             fileId++;
             var html="Add: ";
		html = html+"<input id=\"client_attachment_"+fileId+"\" type=\"file\" name=\"client[attachment_"+fileId+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement2(\'client[attachment_' + fileId + ']\',\'' + fileId + '\'); return false;"><span class="removebro">Remove</span></a>';

if(arr2str.search(fileId)==-1)
    {
       
        document.getElementById("totfile").value = document.getElementById("totfile").value+","+fileId;
		addElement('ItemFiles', 'p', 'client[attachment_' + fileId+']', html);
    }
 else
     {
        
         for(var i=0;i<myfile_array.length;i++)
             {
             if(myfile_array.length==i+1)
                 {
                     if(myfile_array.length!=6)
                         {
                     var fileTag = parseInt(myfile_array[i])+1;
                    
                     fileId = fileTag;
                     document.getElementById("totfile").value = document.getElementById("totfile").value+","+fileId;
                     var html="Add: ";
		html = html+"<input id=\"client_attachment_"+fileTag+"\" type=\"file\" name=\"client[attachment_"+fileTag+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement2(\'client[attachment_' + fileTag + ']\',\'' + fileId + '\'); return false;"><span class="removebro">Remove</span></a>';
                    if(fileTag<7)
                     addElement('ItemFiles', 'p', 'client[attachment_' + fileTag+']', html);
                     else
                        fileId = 6;
                         }
                 }
                 else
                     {
                        
                         if(!myfile_array.contains("1"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",1";
                                 
                                 fileTagAdd(1);
                                 break;
                             }
                          else if(!myfile_array.contains("2"))
                             {
                                document.getElementById("totfile").value = document.getElementById("totfile").value+",2";
                                 
                                 fileTagAdd(2);
                                 break;
                             }
                          else if(!myfile_array.contains("3"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",3";
                                
                                 fileTagAdd(3);
                                 break;
                             }
                          else if(!myfile_array.contains("4"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",4";
                                
                                 fileTagAdd(4);
                                break;
                             }
                          else if(!myfile_array.contains("5"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",5";
                                 
                                 fileTagAdd(5);
                                 break;
                             }
                          else if(!myfile_array.contains("6"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",6";
                                 
                                 fileTagAdd(6);
                                 break;
                             }
                     }

         //alert("For loop==>"+myfile_array[i])
             }
     }
                if(fileId==6 || myfile_array.length==6 )
		document.getElementById('uploadlink').style.display = 'none';
		}

function fileTagAdd(id)
{
     var html="Add: ";
		html = html+"<input id=\"client_attachment_"+id+"\" type=\"file\" name=\"client[attachment_"+id+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement2(\'client[attachment_' + id + ']\',\'' + id + '\'); return false;"><span class="removebro">Remove</span></a>';
           return addElement('ItemFiles', 'p', 'client[attachment_' + id+']', html);
}


Array.prototype.contains = function (element) {
for (var i = 0; i < this.length; i++) {
if (this[i] == element) {
return true;
}
}
return false;
}





function testT()
{
    //alert(document.getElementById("tt").value);
    alert("test tes")
} */


function SetHTML1(type1,type2) {
//alert(type1);
//alert(type2);
		document.getElementById("a1").style.display = "none"
		document.getElementById("a11").style.display = "none"
		document.getElementById("b1").style.display = "none"
		document.getElementById("b11").style.display = "none"
		document.getElementById("c1").style.display = "none"
		document.getElementById("c11").style.display = "none"
		// Using style.display="block" instead of style.display="" leaves a carriage return
		document.getElementById(type1).style.display = "block"
		document.getElementById(type2).style.display = "block"
	}


        function addFileForMessage()
	{
             var existfile = document.getElementById("totfile").value;
             var myfile_array=existfile.split(",");
             var arr2str = myfile_array.toString();

             fileId++;

             if(arr2str.length!=0)
             {
                      if(!myfile_array.contains("2"))
                             {
                                document.getElementById("totfile").value = document.getElementById("totfile").value+",2";

                                 fileTagAdd(2);

                             }
                          else if(!myfile_array.contains("3"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",3";

                                 fileTagAdd(3);

                             }
                          else if(!myfile_array.contains("4"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",4";

                                 fileTagAdd(4);

                             }
                          else if(!myfile_array.contains("5"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",5";

                                 fileTagAdd(5);

                             }
                          else if(!myfile_array.contains("6"))
                             {
                                 document.getElementById("totfile").value = document.getElementById("totfile").value+",6";

                                 fileTagAdd(6);

                             }
             }
             else
             {

             var html="Add : ";
		html = html+"<input id=\"attachment_"+fileId+"\" type=\"file\" name=\"message[attachment_"+fileId+"]\" size=\"30\"/>" +
	    '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'message[attachment_' + fileId + ']\'); return false;"><span class="removebro">Remove</span></a>';

                addElement('ItemFiles', 'p', 'message[attachment_' + fileId+']', html);

                if(fileId==6)
                    uploadlink = document.getElementById('uploadlink')
                 if (uploadlink) {
                     document.getElementById('uploadlink').style.display = 'none';
                 }
             }

             var finalTotFile = document.getElementById("totfile").value;
             var finalTotFileArr = finalTotFile.split(",");

if(finalTotFileArr.length==6)
    {

        document.getElementById('uploadlink').style.display = 'none';
    }

		}

function addAttachmnetForOrder()
{
    var existfile = document.getElementById("totfile").value;

    var myfile_array=existfile.split(",");
    var arr2str = myfile_array.toString();
    fileId = arr2str.length;

    if(arr2str.length != 0)
    {
        if(!myfile_array.contains("2"))
        {
            document.getElementById("totfile").value = document.getElementById("totfile").value+",2";

            fileTagAddForOrderEdit(2);

        }
        else if(!myfile_array.contains("3"))
        {
            document.getElementById("totfile").value = document.getElementById("totfile").value+",3";

            fileTagAddForOrderEdit(3);

        }
        else if(!myfile_array.contains("4"))
        {
            document.getElementById("totfile").value = document.getElementById("totfile").value+",4";

            fileTagAddForOrderEdit(4);

        }
        else if(!myfile_array.contains("5"))
        {
            document.getElementById("totfile").value = document.getElementById("totfile").value+",5";

            fileTagAddForOrderEdit(5);

        }
        else if(!myfile_array.contains("6"))
        {
            document.getElementById("totfile").value = document.getElementById("totfile").value+",6";

            fileTagAddForOrderEdit(6);

        }
    }
    else
    {
        if (fileId == 0) {
            fileId = 1;
            document.getElementById("totfile").value = fileId;
        }
        if(fileId > 5) {
//            document.getElementById('uploadlink').style.display = 'none';
            document.getElementById('attachment_count-error').innerHTML = 'Maximum 6 attachment files can upload';
        } else {
            var html="Add : ";
            html = html+"<input id=\"order_attachment_"+fileId+"\" type=\"file\" name=\"order[order_attachment_"+fileId+"]\" size=\"30\"/>" +
                '&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:removeElement(\'order[order_attachment_' + fileId + ']\'); return false;"><span class="removebro">Remove</span></a>' + " (" + fileId + " of " + 6 + ") ";

            addElement('ItemFiles', 'p', 'order[order_attachment_' + fileId+']', html);
            fileId++;
        }
    }

    var finalTotFile = document.getElementById("totfile").value;
    var finalTotFileArr = finalTotFile.split(",");

    if(finalTotFileArr.length > 5)
    {

//        document.getElementById('uploadlink').style.display = 'none';
        document.getElementById('attachment_count-error').innerHTML = 'Maximum 6 attachment files can upload';
    }

}