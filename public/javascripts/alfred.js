var project_blocks = {
	
	UPDATE_URL:'/utility/get_status',
	
	// toggle the element's description
	toggle_description:function(id) {
		var obj = this.elementize(id);
		$($(obj).id+'_description').toggle();
	},

	// change the status of the project
	start_status_polling:function(id,interval,display) {
		var obj = this.elementize(id);
		new Ajax.PeriodicalUpdater(	obj,
																this.UPDATE_URL + '/' + id + '?display=' + display,
																{ frequency:interval });
	},

	// turn an id into an element reference
	elementize:function(id) {
		return $('project_'+id);
	}

}

var settings_blocks = {
	
	// get the server's hostname
	get_hostname:function(obj) {
		new Ajax.Request(	'/utility/hostname',
											{ asynchronous:true,
												onSuccess:function(response) {
													$(obj).value = response.responseText
												},
												onFailure:function(response) {
													$(obj).value = 'unknown'
												}
											});
	}
}