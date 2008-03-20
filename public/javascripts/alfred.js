var project_blocks = {
	
	// toggle the element's description
	toggle_description:function(id) {
		var obj = this.elementize(id);
		$($(obj).id+'_description').toggle();
	},

	// change the status of the project
	update_status:function(obj,status) {
		var obj = this.elementize(id);
	},

	// check on the status of the project
	check_status:function(obj) {
		var obj = this.elementize(id);
	},

	// turn an id into an element reference
	elementize:function(id) {
		return $('project_'+id);
	}

}