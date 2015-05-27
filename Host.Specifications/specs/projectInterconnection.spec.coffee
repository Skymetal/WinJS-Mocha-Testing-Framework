describe "Project interconnection", ->

    it "should have the ProjectInterconnection Namespace", ->
        expect(ProjectInterconnection).to.exist

    it "should have the isWorkingBoolean set to true", ->
    	expect(ProjectInterconnection.isWorkingBoolean).to.be.true

    it "should have the isWorkingString set to 'Its working!'", ->
    	expect(ProjectInterconnection.isWorkingString).to.equal("It's Working!")