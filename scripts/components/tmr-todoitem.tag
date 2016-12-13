<tmr-todoitem>
    <div class="view"> 
        <input if={opts.todo.completed} class="toggle" type="checkbox" checked="checked" onclick={toggleTodo}>
        <input if={!opts.todo.completed} class="toggle" type="checkbox" onclick={toggleTodo}>

        <label ondblclick={editTodo}>{opts.todo.title}</label>
        <button class="destroy" onclick={removeTodo}></button>
    </div>
    <input ref="todoeditbox" class="edit" type="text" onblur={doneEdit} onkeyup={editKeyUp}>

    <script>
        var ENTER_KEY = 13;
        var ESC_KEY = 27;
        
        opts.todo.editing = false;

        this.toggleTodo = () => {
            opts.todo.completed = !opts.todo.completed;
            opts.parentview.saveTodos();
            return true;
        };

        this.editTodo = () => {
            if (opts.todo.editing) {
                return;
            }

            opts.todo.editing = true;
            this.refs.todoeditbox.value = opts.todo.title;
        };

        this.removeTodo = () => {
            opts.parentview.removeTodo(opts.todo);
        };

        this.doneEdit = () => {
            if (!opts.todo.editing) {
                return;
            }
            opts.todo.editing = false;
            var enteredText = this.refs.todoeditbox.value && this.refs.todoeditbox.value.trim();
            if (enteredText) {
                opts.todo.title = enteredText;
                opts.parentview.saveTodos();
            } else {
                this.removeTodo();
            }
        };

        this.editKeyUp = (e) => {
            if (e.which === ENTER_KEY) {
                this.doneEdit();
            } else if (e.which === ESC_KEY) {
                this.todoeditbox.value = opts.todo.title;
                this.doneEdit();
            }
        };

        this.on('update', () => {
            if (opts.todo.editing) {
                opts.parentview.update();
                this.todoeditbox.focus();
            }
        });
	</script>
</tmr-todoitem>
