
import './components/tmr-todo.tag';
import './components/tmr-todoitem.tag';

import store from "./store";

riot.mount('tmr-todo', { data: store.fetch() });