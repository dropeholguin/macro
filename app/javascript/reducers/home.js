const homeReducer = (state = 'HOME_PAGE', action) => {
  switch (action.type) {
    case 'SHOW_LOGIN':
      return action.filter
    default:
      return state
  }
}

export default homeReducer
