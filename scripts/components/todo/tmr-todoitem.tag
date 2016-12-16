<tmr-todoitem>
    <li class="todo {editing: editing, completed: opts.todo.completed}">
        <div class="view"> 
            <input ref="togglechecked" class="toggle" type="checkbox" onclick={toggle} />
            <label ondblclick={edit}>{opts.todo.title}</label>
            <button class="destroy" onclick={remove}></button>
        </div>
        <input ref="todoeditbox" class="edit" type="text" onblur={doneEdit} onkeyup={editKeyUp}>
    </li>

    <script>
    
        const ENTER_KEY = 13;
        const ESC_KEY = 27;

        this.remove = () => {
            this.parent.removeTodo(this.opts.todo);
        };

        this.edit = () => {
            this.refs.todoeditbox.value = opts.todo.title;
            this.editing = true;
        };

        this.toggle = () => {
            this.parent.toggleCompleted(this.opts.todo);
        };

        this.doneEdit = () => {
            if(!this.editing)
                return;

            const newTitle = this.refs.todoeditbox.value;
            this.editing = false;
            this.parent.editTodo(this.opts.todo, this.refs.todoeditbox.value);
        };

        this.editKeyUp = (e) => {
            switch(e.which) {
                case ENTER_KEY:
                    this.doneEdit();
                    break;
                case ESC_KEY:
                    this.editing = false;
                    break;
            }
        };

        this.on('mount', () => this.refs.togglechecked.checked = opts.todo.completed);
        this.on('updated', () => this.refs.togglechecked.checked = opts.todo.completed);
    </script>
</tmr-todoitem>
