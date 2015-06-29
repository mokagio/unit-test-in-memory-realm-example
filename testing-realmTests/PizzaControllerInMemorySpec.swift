import Quick
import Nimble
import RealmSwift
import testing_realm

class PizzaControllerInMemorySpec: QuickSpec {
    override func spec() {
        describe("PizzaController") {
            var testRealm: Realm!
            var sut: PizzaController!

            beforeEach{
                testRealm = Realm(inMemoryIdentifier: "pizza-controller-spec")
                sut = PizzaController(realm: testRealm)
            }

            afterEach {
                testRealm.write {
                    testRealm.deleteAll()
                }
            }

            it("adds the Pizza to the Realm") {
                expect(testRealm.objects(Pizza).count).to(equal(0))

                let p = Pizza()
                p.name = "Margherita"
                sut.addPizza(p)

                expect(testRealm.objects(Pizza).count).to(equal(1))
            }

            it("adds the Pizza to the Realm other \(TestConfiguration().iterations) times, to test the speed") {
                let end = TestConfiguration().iterations
                for i in 0..<end {
                    let p = Pizza()
                    p.name = "Margherita"
                    sut.addPizza(p)
                }
                expect(testRealm.objects(Pizza).count).to(equal(end))
            }
        }
    }
}
