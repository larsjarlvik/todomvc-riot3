<tmr-todo>
    <form onsubmit={addTodo}>
        <input ref="todotitle" class="new-todo" autofocus autocomplete="off" placeholder="What needs to be done?">
    </form>

    <section class="main" show={state.todos.length}>
        <input ref="toggleall" class="toggle-all" type="checkbox" onclick={toggleallCompleted}>
        <ul class="todo-list">
            <tmr-todoitem each={t in state.todos} show={filter(t)} todo={t} />
        </ul>
    </section>

    <footer class="footer" show={state.todos.length}>
        <span class="todo-count">
            <strong>{state.remaining}</strong> {state.remaining === 1 ? 'item' : 'items'} left
        </span>
        <ul class="filters">
            <li><a class={selected: state.activeFilter === 'all'} href="#/all">All</a></li>
            <li><a class={selected: state.activeFilter === 'active'} href="#/active">Active</a></li>
            <li><a class={selected: state.activeFilter === 'completed'} href="#/completed">Completed</a></li>
        </ul>
        <button class="clear-completed" onclick={removeCompleted} show={state.todos.length > state.remaining}>Clear completed</button>
    </footer>


    <script type="javascript">
        import store from './store';
        import routing from './routing';

        this.addTodo = (e) => { 
            store.dispatch({ type: 'add', todo: { 
                title: this.refs.todotitle.value,
                completed: false
            }});

            this.refs.todotitle.value = '';
            e.preventDefault();
        };

        this.filter = (todo) => {
            switch(this.state.activeFilter) {
                case 'all':
                    return true;
                case 'active':
                    return todo.completed === false;
                case 'completed':
                    return todo.completed === true;
            }

            return true;
        }

        this.removeTodo = (todo) =>         store.dispatch({ type: 'remove', todo });
        this.editTodo = (todo, newTitle) => store.dispatch({ type: 'edit', todo, newTitle });
        this.toggleCompleted = (todo) =>    store.dispatch({ type: 'toggleCompleted', todo });
        this.toggleallCompleted = () =>     store.dispatch({ type: 'toggleAllCompleted' });

        this.stateChange = () => {
            this.state = store.getState();

            if(this.isMounted) {
                this.refs.toggleall.checked = this.state.remaining === 0;
            }

            this.update();
        };

        this.on('unmount', () => store.unsubscribe(this.stateChange));

        store.subscribe(this.stateChange);
        store.dispatch({ type: 'init' });
        routing.start(store);

    </script>
</tmr-todo>
