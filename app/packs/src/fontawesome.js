import { dom, library } from '@fortawesome/fontawesome-svg-core'
import { faCalendar, faChevronLeft, faChevronRight, faMinus, faPlus } from '@fortawesome/free-solid-svg-icons'
import { faCheckSquare, faComments, faSquare } from '@fortawesome/free-regular-svg-icons'

library.add(
  faCalendar, faChevronLeft, faChevronRight, faMinus, faPlus,
  faCheckSquare, faComments, faSquare
)

dom.watch()
