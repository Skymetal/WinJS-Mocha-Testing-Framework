describe "oauth", ->

	server = null

	beforeEach ->
		server = sinon.fakeServer.create()
		server.respondWith("GET", "http://themalldataserver.azurewebsites.net/retailers",
			[200, { "Content-Type": "application/json" }, "{ retailers: 'success' }"])

	it "should have a VonBismark namespace with an oauth class in it", () ->
		expect(vonbismark.oauthclient).to.exist

	it.skip "should have an intentional failure", ->
		expect(false).to.be.true

	it "should have a test function that executes an xhr request", (done) ->
		callback = sinon.spy()

		vonbismark.oauthclient.getTest("http://themalldataserver.azurewebsites.net/retailers").then(callback).done () ->
    		expect(callback).to.have.been.calledWith("{ retailers: 'sucscess' }")
    		# expect(callback.calledWith("{ retailers: 'success' }")).to.be.true
    		done()

		server.respond()