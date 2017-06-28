const homeReducer = (state = 'HOME_PAGE', action) => {
  switch (action.type) {
    case 'SHOW_LOGIN':
      return action.filter
    case 'WITHDRAW':
      console.log(action.amount)
      return {
        state,
        redirect: true
      }
    default:
      return state
  }
}

export default homeReducer
