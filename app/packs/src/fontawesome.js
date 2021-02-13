import { dom, library } from '@fortawesome/fontawesome-svg-core'
import { faCalendar, faMinus, faPlus, faTimes } from '@fortawesome/free-solid-svg-icons'
import { faCheckSquare, faSquare } from '@fortawesome/free-regular-svg-icons'

library.add(
  faCalendar, faMinus, faPlus, faTimes,
  faCheckSquare, faSquare
)

dom.watch()
