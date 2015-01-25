package winston

import grails.plugin.springsecurity.annotation.Secured
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured([Role.ROLE_USER])
class DecisionTreeResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DecisionTreeResult.list(params), model:[decisionTreeResultInstanceCount: DecisionTreeResult.count()]
    }

    def show(DecisionTreeResult decisionTreeResultInstance) {
        respond decisionTreeResultInstance
    }

    def create() {
        respond new DecisionTreeResult(params)
    }

    @Transactional
    def save(DecisionTreeResult decisionTreeResultInstance) {
        if (decisionTreeResultInstance == null) {
            notFound()
            return
        }

        if (decisionTreeResultInstance.hasErrors()) {
            respond decisionTreeResultInstance.errors, view:'create'
            return
        }

        decisionTreeResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'decisionTreeResult.label', default: 'DecisionTreeResult'), decisionTreeResultInstance.id])
                redirect decisionTreeResultInstance
            }
            '*' { respond decisionTreeResultInstance, [status: CREATED] }
        }
    }

    def edit(DecisionTreeResult decisionTreeResultInstance) {
        respond decisionTreeResultInstance
    }

    @Transactional
    def update(DecisionTreeResult decisionTreeResultInstance) {
        if (decisionTreeResultInstance == null) {
            notFound()
            return
        }

        if (decisionTreeResultInstance.hasErrors()) {
            respond decisionTreeResultInstance.errors, view:'edit'
            return
        }

        decisionTreeResultInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DecisionTreeResult.label', default: 'DecisionTreeResult'), decisionTreeResultInstance.id])
                redirect decisionTreeResultInstance
            }
            '*'{ respond decisionTreeResultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DecisionTreeResult decisionTreeResultInstance) {

        if (decisionTreeResultInstance == null) {
            notFound()
            return
        }

        decisionTreeResultInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DecisionTreeResult.label', default: 'DecisionTreeResult'), decisionTreeResultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'decisionTreeResult.label', default: 'DecisionTreeResult'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
