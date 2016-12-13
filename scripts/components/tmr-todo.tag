

<tmr-todo>

    <input class="new-todo" autofocus autocomplete="off" placeholder="What needs to be done?" onkeyup={ addTodo }>

    <section class="main" show={todos.length}>
        <input class="toggle-all" type="checkbox" checked={allDone} onclick={toggleAll}>
        <ul class="todo-list">
            <li each={t, i in filteredTodos()} class="todo {completed: t.completed, editing: t.editing}">
                <tmr-todoitem completed={t.completed} editing={t.editing} todo={t} parentview={parent}></tmr-todoitem>
            </li>
        </ul>
    </section>

    <footer class="footer" show={ todos.length }>
        <span class="todo-count">
            <strong>{remaining}</strong> {remaining === 1 ? 'item' : 'items'} left
        </span>
        <ul class="filters">
            <li><a class={selected: activeFilter=='all'} href="#/all">All</a></li>
            <li><a class={selected: activeFilter=='active'} href="#/active">Active</a></li>
            <li><a class={selected: activeFilter=='completed'} href="#/completed">Completed</a></li>
        </ul>
        <button class="clear-completed" onclick={removeCompleted} show={todos.length > remaining}>Clear completed</button>
    </footer>

    <script type="javascript">
        import store from "../store";
        import route from "riot-route";

        const ENTER_KEY = 13;
        this.todos = opts.data || [];

        route('/*', (name) => {
            this.activeFilter = name || 'all';
            this.update();
        });
        route.start(true);

        this.on('update', () => {
            this.remaining = this.todos.filter(function(t) {
                return !t.completed;
            }).length;
            this.allDone = this.remaining === 0;
            this.saveTodos();
        });

        this.saveTodos = () => {
            store.save(this.todos);
        };

        this.filteredTodos = () => {
            if (this.activeFilter === 'active') {
                return this.todos.filter(function(t) {
                    return !t.completed;
                });
            } else if (this.activeFilter === 'completed') {
                return this.todos.filter(function(t) {
                    return t.completed;
                });
            } else {
                return this.todos;
            }
        };

        this.addTodo = function(e) {
            if (e.which === ENTER_KEY) {
                var value = e.target.value && e.target.value.trim();
                if (!value) {
                    return;
                }
                this.todos.push({ title: value, completed: false });
                e.target.value = '';
            }
        };

        this.removeTodo = (todo) => {
            this.todos.some((t) => {
                if (todo === t) {
                    this.todos.splice(this.todos.indexOf(t), 1);
                    this.update();
                }
            });
        };

        this.toggleAll = (e) => {
            this.todos.forEach((t) => {
                t.completed = e.target.checked;
            });
            
            return true;
        };

        this.removeCompleted = () => {
            this.todos = this.todos.filter((t) => {
                return !t.completed;
            });

        };

        route((base, filter) => {
            this.activeFilter = filter;
            this.update();
        });

    </script>
</tmr-todo>
