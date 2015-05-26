describe "Basic WinJS functionality", ->

    it "should have WinJS", ->
        expect(WinJS).to.exist

    it "should fail a test", ->
        expect(false).to.equal(true, "fail")
