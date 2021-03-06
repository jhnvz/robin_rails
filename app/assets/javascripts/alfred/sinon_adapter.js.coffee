class Alfred.SinonAdapter

  ###*
   * Serves an Alfred response server.
   * @action {String} Controller and action
   * @name {String} Name of the scenario
   *
   * @example
   * server = Alfred.SinonAdapter.serve('sessions/current', 'default')
   * server.respond()
   *
   * @returns
   * {Object} Sinon FakeServer
   *
   ###
  @serve: (action, name, path) ->
    scenario  = Alfred.fetch(action, name)
    meta      = scenario.meta
    path      ||= @_path(meta.path)

    server = sinon.fakeServer.create()
    server.respondWith meta.method, path, [meta.status, { 'Content-Type': meta.type }, scenario.response]

    server

  ###*
   * Makes sure the path is correct, without starting slash
   * @path {String} Path to correct
   *
   ###
  @_path: (path) ->
    if path[0] == '/'
      path.slice(1, path.length)
    else
      path
