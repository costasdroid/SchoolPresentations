/*!
 * menu JavaScript  v1
 *
 */

function change_section() {
top.location= document.getElementsByName('section')[0].value;
}
function hideHeader(){
	$('#eclass_ebook_header').css('height','0px');
	$('#tools').hide();
	$('#eclass_ebook_body').css('margin-top','0px');
	$('#hideDisplay').hide();
	$('#showDisplay').show();
}
function showHeader(){
	$('#eclass_ebook_header').css('height','100px');
	$('#tools').show();
	$('#eclass_ebook_body').css('margin-top','100px');
	$('#hideDisplay').show();
	$('#showDisplay').hide();
}
jQuery(document).ready(function() {
	next=$("#bookup select option:selected" ).next();
	while(next.size()>0 && next.val()==$("#bookup select option:selected").val()){		
		tmp=next.next();
		next=tmp;
	}
	if(next.size()>0 && next.val()!=$("#bookup select option:selected").val()){
		$('#next_active').attr('href',next.val());
		$('#next_active img').attr('alt',next.text().replace(/&nbsp;/g, ''));
		$('#next_active img').attr('title',next.text().replace(/&nbsp;/g, ''));
		$('#next_active').show();
	}else{
		$('#next_inactive').show();
	}
	previous=$("#bookup select option:selected" ).prev();
	while(previous.size()>0 && previous.val()==$("#bookup select option:selected").val()){		
		tmp=previous.prev();
		previous=tmp;
	}
	if (previous.size()>0 && previous.val()!=$("#bookup select option:selected").val()){
		$('#prev_active').attr('href', previous.val());
		$('#prev_active img').attr('alt', previous.text().replace(/&nbsp;/g, ''));
		$('#prev_active img').attr('title', previous.text().replace(/&nbsp;/g, ''));
		$('#prev_active').show();
	}else{
		$('#prev_inactive').show();
	}
});