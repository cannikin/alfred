var project_blocks = {
	
	UPDATE_URL:'/utility/get_status',
	STATES:['running','stopped','starting','error'],
	
	// toggle the element's description
	toggle_description:function(id) {
		var obj = this.elementize(id);
		$($(obj).id+'_description').toggle();
	},

	// change the status of the project
	start_status_polling:function(id,interval,display) {
		var obj = this.elementize(id);
		new Ajax.PeriodicalUpdater(	'',
																this.UPDATE_URL + '/' + id + '?display=' + display,
																{ frequency:interval,
																	onSuccess:function(response) {
																		// remove any existing states from the classname
																		STATES.each(function(state) {
																			obj.removeClassName(state);
																		});
																		// add the new state's class
																		obj.addClassName(response.responseText);
																	}
																}
															);
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