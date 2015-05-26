describe "Basic winjs functionality we expect from namespaces and classes", ->

	describe "Namespaces", ->
		it "should have the PlatformNS namespace", ->
			expect(PlatformNS).to.exist
		it "should have the platform class", ->
			myClass = new PlatformNS.platform('myValue')
			expect(myClass).to.exist
			expect(myClass.testInstance).to.equal('myValue')

	describe "Classes", ->
		it "should have a WinJS Class with constructor", (done) ->
			myClass = new PlatformNS.platform()
			expect(myClass).to.exist
			done()

		it "should be able take in a parameter in its constuctor and return it", (done) ->
			myClass = new PlatformNS.platform("testParam")
			expect(myClass.testParam).to.equal("testParam")
			done()

		it "should have an instance variable with the value 'instance'", (done) ->
			myClass = new PlatformNS.platform()
			expect(myClass.testInstance).to.exist
			expect(myClass.testInstance).to.equal("instance")
			done()

		it "should have a static variable with the value 'staticVar", (done) ->
			expect(PlatformNS.platform.testStatic).to.exist
			expect(PlatformNS.platform.testStatic).to.equal("staticVar")
			done()

		it "should set the constructor parameter to the instance variable", (done) ->
			myClass = new PlatformNS.platform("testParam")
			expect(myClass.testInstance).to.equal("testParam")
			done()

	describe "Static vs instance", ->
		originalStatic = PlatformNS.platform.getStatic
		
		beforeEach ->
			PlatformNS.platform.testStatic = "staticVar"
			PlatformNS.platform.getStatic = originalStatic

		it "should have only a single copy of the getStatic function", -> 
			classA = new PlatformNS.platform('a')
			classB = new PlatformNS.platform('b')


			classA.constructor.getStatic = ->
				"customFunction"

			setValue = classA.setStatic("something")
			
			expect(setValue).to.equal('something')
			expect(PlatformNS.platform.testStatic).to.equal('something')

			expect(classA.constructor.getStatic()).to.equal('customFunction')
			expect(classB.constructor.getStatic()).to.equal('customFunction')
			expect(PlatformNS.platform.testStatic).to.equal('something')

		it "should have multiple copies of the same class with the same static value", (done) ->
			expect(PlatformNS.platform.testStatic).to.exist
			expect(PlatformNS.platform.testStatic).to.equal("staticVar")

			classA = new PlatformNS.platform("classA")
			classB = new PlatformNS.platform("classB")

			expect(PlatformNS.platform.testStatic).to.exist
			expect(PlatformNS.platform.testStatic).to.equal("staticVar")

			classA.setStatic("classA")

			expect(classA.constructor.getStatic()).to.equal('classA', 'error1')
			expect(classB.constructor.getStatic()).to.equal('classA', 'error2')
			expect(PlatformNS.platform.testStatic).to.equal("classA", 'error3')

			done()

		it "should be able to change the static variable and have the correct value", (done) ->
			PlatformNS.platform.testStatic = "someOtherValue"
			myClass = new PlatformNS.platform()
			expect(myClass.constructor.getStatic()).to.equal("someOtherValue")
			done()		

		it "should have instance copies of the setStatic function", -> 
			classA = new PlatformNS.platform('a')
			classB = new PlatformNS.platform('b')
			classA.setStatic = ->
				"customFunction"

			expect(classA.setStatic("something")).to.equal('customFunction', 'the custom function wasnt set correctly')
			expect(PlatformNS.platform.testStatic).to.equal('staticVar', 'the original function was called')

			expect(classB.setStatic("something")).to.equal('something', 'The second instance was changed somehow')
			expect(PlatformNS.platform.testStatic).to.equal('something', 'The second instance was changed somehow, but differently....')


	describe "Mocking XHR", ->
		server = null

		beforeEach ->
			server = sinon.fakeServer.create()

		it "should return a mocked response with normal XMLHTTPRequest", (done) ->
			heyThereMessage = '[{ "id": 12, "comment": "Hey there" }]'
			server.respondWith("GET", "http://localhost/requesturi.json", [200, { "Content-Type": "application/json" }, heyThereMessage])

			callback = sinon.spy()

			WinJS.xhr({
	            url: "http://localhost/requesturi.json",
	            responseType: "application/json"
        	}).then((result) ->
    			callback(result.responseText)
			).done(() ->
	    		expect(callback.calledWith(heyThereMessage)).to.be.true
	    		done()
    		)

			server.respond()
