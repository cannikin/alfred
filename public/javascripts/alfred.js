var project_blocks = {
	
	UPDATE_URL:'/utility/get_state',
	START_URL:'/utility/start_project',
	RESTART_URL:'/utility/restart_project',
	STOP_URL:'/utility/stop_project',
	CLEAR_URL:'/utility/clear_project',
	STARTING_STATE:{'class':'starting','buttons':[{'value':'Starting...','disabled':'disabled'}]},
	STOPPING_STATE:{'class':'stopping','buttons':[{'value':'Stopping...','disabled':'disabled'}]},
	RESTART_STATE:{'class':'restart','buttons':[{'value':'Restarting...','disabled':'disabled'}]},
	STATES:['running','stopped','starting','stopping','error','restart'],
	
	// toggle the element's description
	toggle_description:function(id) {
		var obj = this.elementize(id);
		$($(obj).id+'_description').toggle();
	},

	// change the status of the project
	start_status_polling:function(id,interval,display) {
		var obj = this.elementize(id);
		var self = this;
		
		new Ajax.PeriodicalUpdater(	'',
									this.UPDATE_URL + '/' + id + '?display=' + display,
									{	frequency:interval,
										onSuccess:function(response) {
											self.update_state(obj,response.responseText.evalJSON());
										}
									}
								);
	},
	
	start:function(id,wait) {
		var obj = this.elementize(id);
		var self = this;
		// this says whether to wait for the call to complete before returning (non-asynchronous)
		var wait = wait ? wait : false;

		this.update_state(obj, this.STARTING_STATE);
		
		new Ajax.Request(	this.START_URL + '/' + id,
							{	asynchronous:!wait,
								onSuccess:function(response) {
									self.update_state(obj,response.responseText.evalJSON());
								}
							}
						);
	},

	stop:function(id,wait) {
		var obj = this.elementize(id);
		var self = this;
		var wait = wait ? wait : false;

		this.update_state(obj, this.STOPPING_STATE);

		new Ajax.Request(	this.STOP_URL + '/' + id,
							{	asynchronous:!wait,
								onSuccess:function(response) {
									self.update_state(obj,response.responseText.evalJSON());
								}
							}
						);
	},

	restart:function(id) {
		var obj = this.elementize(id);
		this.update_state(obj, this.RESTART_STATE);

		this.stop(id,true);
		this.start(id);
	},

	clear:function(id) {
		var obj = this.elementize(id);
		var self = this;
		new Ajax.Request(	this.CLEAR_URL + '/' + id,
							{	onSuccess:function(response) {
									self.update_state(obj,response.responseText.evalJSON());
								}
							}
						);
	},
		
	update_state:function(obj,new_state) {
		// update class
		this.STATES.each(function(state) {
			obj.removeClassName(state);
		});
		obj.addClassName(new_state['class']);
		
		// update button
		var id = obj.id.split('_').last();
		var html = '';
		new_state.buttons.each(function(button) {
			html += '<input type="button" ';
			for(key in button) {
				html += key + '="' + button[key].gsub(/__id__/,id) + '" ';
			}
			html += '/>';
		});
		// add notes about current state, if any
		if(new_state.notes) {
			html += '<p>' + new_state.notes + ' <a href="#" onclick="project_blocks.clear(' + id + '); return false;">clear</a></p>';
		}

		// update project
		$('project_'+id+'_form').update(html);
	},

	update_button:function(id,properties) {
		var output = '<input type="button" ';
		for(key in properties) {
			output += key + '="' + properties[key].gsub(/__id__/,id) + '" ';
		}
		output += '/>';
		$('project_'+id+'_form').update(output);
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
