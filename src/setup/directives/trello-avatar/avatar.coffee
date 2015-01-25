angular.module '%module%.setup'
.factory 'Avatar',
($http, storage, trello) ->
  getMemberFromTrello = (memberId) ->
    return unless memberId
    $http
      method: 'get'
      url: trello.apiUrl + '/members/' + memberId
      params:
        key: trello.applicationKey
        token: storage.token
    .then (res) ->
      res.data

  getMember = (memberId) ->
    getMemberFromTrello memberId
    .then (member) ->
      if member.uploadedAvatarHash
        hash = member.uploadedAvatarHash
      else if member.avatarHash
        hash = member.avatarHash
      else
        hash = null
      return {
        username: member.username
        fullname: member.fullname
        hash: hash
        initials: member.initials
      }

  getMember: getMember
